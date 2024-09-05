import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { TopicsService } from './topics.service';
import { CreateTopicDto } from './dto/create-topic.dto';
import { UpdateTopicDto } from './dto/update-topic.dto';
import { PaginationDto } from 'src/common/dto/pagination.dto';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiQuery,
} from '@nestjs/swagger';
import { Topic } from './entities/topic.entity';

@ApiTags('Temas de los cursos')
@Controller('topics')
export class TopicsController {
  constructor(private readonly topicsService: TopicsService) {}

  @Post()
  @ApiOperation({ summary: 'Crear un nuevo tema' })
  @ApiResponse({
    status: 201,
    description: 'El tema ha sido creado exitosamente.',
    type: Topic,
  })
  @ApiResponse({
    status: 400,
    description: 'Error en los datos proporcionados.',
  })
  create(@Body() createTopicDto: CreateTopicDto) {
    return this.topicsService.create(createTopicDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todos los temas con paginación' })
  @ApiResponse({ status: 200, description: 'Lista de temas.', type: [Topic] })
  @ApiResponse({ status: 400, description: 'Error en la consulta de datos.' })
  findAll(@Query() paginationDTO: PaginationDto) {
    return this.topicsService.findAll(paginationDTO);
  }

  @Get('course/:courseId')
  @ApiOperation({ summary: 'Obtener todos los temas de un curso' })
  @ApiParam({ name: 'courseId', type: String, description: 'ID del curso' })
  @ApiResponse({ status: 200, description: 'Lista de temas.', type: [Topic] })
  @ApiResponse({ status: 400, description: 'Error en la consulta de datos.' })
  findAllByCourse(
    @Param('courseId') courseId: string,
    @Query() paginationDTO: PaginationDto,
  ) {
    return this.topicsService.findAllByCourse(courseId, paginationDTO);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener un tema por ID' })
  @ApiParam({ name: 'id', type: String, description: 'ID del tema' })
  @ApiResponse({ status: 200, description: 'Tema encontrado.', type: Topic })
  @ApiResponse({ status: 404, description: 'Tema no encontrado.' })
  findOne(@Param('id') id: string) {
    return this.topicsService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar un tema existente' })
  @ApiParam({ name: 'id', type: String, description: 'ID del tema' })
  @ApiResponse({
    status: 200,
    description: 'Tema actualizado exitosamente.',
    type: Topic,
  })
  @ApiResponse({
    status: 400,
    description: 'Error en los datos proporcionados.',
  })
  @ApiResponse({ status: 404, description: 'Tema no encontrado.' })
  update(@Param('id') id: string, @Body() updateTopicDto: UpdateTopicDto) {
    return this.topicsService.update(id, updateTopicDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar un tema por ID' })
  @ApiParam({ name: 'id', type: String, description: 'ID del tema' })
  @ApiResponse({ status: 200, description: 'Tema eliminado exitosamente.' })
  @ApiResponse({ status: 404, description: 'Tema no encontrado.' })
  remove(@Param('id') id: string) {
    return this.topicsService.remove(id);
  }
}
