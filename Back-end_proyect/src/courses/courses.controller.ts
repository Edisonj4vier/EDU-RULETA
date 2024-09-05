import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { CoursesService } from './courses.service';
import { CreateCourseDto } from './dto/create-course.dto';
import { UpdateCourseDto } from './dto/update-course.dto';
import { PaginationDto } from 'src/common/dto/pagination.dto';
import { AuthGuard } from '@nestjs/passport';
import { Auth, GetUser, RoleProtected } from 'src/auth/decorators';
import { User } from 'src/auth/entities/auth.entity';
import { ValidRoles } from 'src/auth/interfaces';
import { UserRoleGuard } from 'src/auth/guards';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Course } from './entities/course.entity';

@ApiTags('Cursos de la plataforma')
@ApiBearerAuth()
@Auth()
@Controller('courses')
export class CoursesController {
  constructor(private readonly coursesService: CoursesService) {}

  @ApiOperation({ summary: 'Crear un nuevo curso' })
  @ApiResponse({
    status: 201,
    description: 'Curso creado exitosamente',
    type: Course,
  })
  @ApiResponse({ status: 400, description: 'Error de validación' })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.teacher, ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  @Post()
  create(@GetUser() user: User, @Body() createCourseDto: CreateCourseDto) {
    return this.coursesService.create(createCourseDto, user);
  }

  @ApiOperation({ summary: 'Obtener todos los cursos con paginación' })
  @ApiResponse({
    status: 200,
    description: 'Lista de cursos obtenida exitosamente',
    type: [Course],
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @Get()
  findAll(@Query() paginationDTO: PaginationDto) {
    return this.coursesService.findAll(paginationDTO);
  }

  @ApiOperation({
    summary: 'Obtener todos los cursos de un usuario con paginación',
  })
  @ApiParam({
    name: 'userId',
    required: true,
    description: 'Identificador único del usuario',
    type: String,
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de cursos del usuario obtenida exitosamente',
    type: [Course],
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  // Obtener todos los cursos de un usuario
  @Get('user/:userId')
  findAllByUser(
    @Param('userId') userId: string,
    @Query() paginationDTO: PaginationDto,
  ) {
    return this.coursesService.findAllByUser(userId, paginationDTO);
  }

  @ApiOperation({ summary: 'Obtener detalles de un curso específico' })
  @ApiParam({
    name: 'id',
    required: true,
    description: 'Identificador único del curso',
    type: String,
  })
  @ApiResponse({
    status: 200,
    description: 'Detalles del curso obtenidos exitosamente',
    type: Course,
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 404, description: 'Curso no encontrado' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.coursesService.findOne(id);
  }

  @ApiOperation({ summary: 'Actualizar un curso existente' })
  @ApiParam({
    name: 'id',
    required: true,
    description: 'Identificador único del curso',
    type: String,
  })
  @ApiResponse({
    status: 200,
    description: 'Curso actualizado exitosamente',
    type: Course,
  })
  @ApiResponse({ status: 400, description: 'Error de validación' })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 404, description: 'Curso no encontrado' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.teacher, ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCourseDto: UpdateCourseDto) {
    return this.coursesService.update(id, updateCourseDto);
  }

  @ApiOperation({ summary: 'Eliminar un curso existente' })
  @ApiParam({
    name: 'id',
    required: true,
    description: 'Identificador único del curso',
    type: String,
  })
  @ApiResponse({
    status: 200,
    description: 'Curso eliminado exitosamente',
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 404, description: 'Curso no encontrado' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.teacher, ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.coursesService.remove(id);
  }
}
